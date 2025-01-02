import { CreationOptional, DataTypes, InferAttributes, InferCreationAttributes, Model } from 'sequelize';
import sequelize from '../configs/database';
import Game from './game';

class GamePlatform extends Model<InferAttributes<GamePlatform>, InferCreationAttributes<GamePlatform>> {
  declare id: CreationOptional<number>;
  declare gameId: number;
  declare platformId: number;
}

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

export default GamePlatform