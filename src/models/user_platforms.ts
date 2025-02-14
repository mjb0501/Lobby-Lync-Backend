import pool from '../config/database';

export interface UserPlatform {
  id?: number;
  userId: number;
  platformId: number;
  platformUsername: string;
}

export const updateUserPlatform = async (platformData: any): Promise<void> => {
  const { userUuid, ...platforms } = platformData;

  //a map that maps each platform to its id in the database
  const platformMap: Record<string, number> = {
    Xbox: 1,
    Playstation: 2,
    Steam: 3,
    Switch: 4,
  };

  //Seperates platform etries from ones that should be updated and ones that should be deleted
  const platformEntriesToUpdate = Object.entries(platforms)
    .filter(([_, username]) => typeof username === 'string' && username.trim() !== '')
    .map(([platform, username]) => [platformMap[platform], username] as [number, string]);

  const platformEntriesToDelete = Object.entries(platforms)
    .filter(([_, username]) => username === '')
    .map(([platform, _]) => platformMap[platform]);

  //If there are no valid entries then do not perform any database manipulation
  if (platformEntriesToUpdate.length === 0 && platformEntriesToDelete.length === 0) {
    console.log('No valid platform entries provided.');
    return;
  }

  const values: (number | string)[] = [userUuid];
  const valuePlaceholders: string[] = [];
  
  //Establishes the placeholders in the insert query
  platformEntriesToUpdate.forEach(([platformId, username], index) => {
    valuePlaceholders.push(`((SELECT id FROM "user" WHERE uuid = $1), $${index * 2 + 2}, $${index * 2 + 3})`);
    values.push(platformId, username);
  });

  const insertUpdateQuery = `
    INSERT INTO user_platform ("userId", "platformId", "platformUsername")
    VALUES ${valuePlaceholders.join(', ')}
    ON CONFLICT ("userId", "platformId") 
    DO UPDATE SET "platformUsername" = EXCLUDED."platformUsername";
  `;

  const deleteQuery = platformEntriesToDelete.length > 0
    ? `DELETE FROM user_platform
       WHERE "userId" = (SELECT id FROM "user" WHERE uuid = $1)
       AND "platformId" IN (${platformEntriesToDelete.join(', ')})`
    : '';

  try {
    // Execute delete query if applicable
    if (deleteQuery) {
      await pool.query(deleteQuery, [userUuid]);
    }

    //Execute insert/update query
    if (platformEntriesToUpdate.length > 0) {
      await pool.query(insertUpdateQuery, values);
    }
  } catch (error) {
    console.error('Error updating platforms:', error);
  }
};