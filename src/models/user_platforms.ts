import { DataTypes, Model } from 'sequelize';
import sequelize from '../config/database';

class UserPlatform extends Model {}

UserPlatform.init({
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  userId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'user',
      key: 'id',
    },
    onDelete: 'CASCADE',
  },
  platformId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'platform',
      key: 'id',
    },
    onDelete: 'CASCADE',
  },
  platformUsername: {
    type: DataTypes.STRING,
    allowNull: false,
  },
}, {
  sequelize,
  modelName: 'user_platform',
  tableName: 'user_platform',
  timestamps: false,
  indexes: [
    {
      unique: true,
      fields: ['userId', 'platformId'],
    },
  ],
});