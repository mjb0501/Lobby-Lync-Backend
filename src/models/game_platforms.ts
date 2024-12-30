import { DataTypes, Model } from 'sequelize';
import sequelize from '../configs/database';

class GamePlatform extends Model {}

GamePlatform.init({
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  gameId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'game',
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
}, {
  sequelize,
  modelName: 'game_platform',
  tableName: 'game_platform',
  timestamps: false,
  indexes: [
    {
      unique: true,
      fields: ['gameId', 'platformId'],
    },
  ],
});