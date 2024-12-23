import { DataTypes, Model } from 'sequelize';
import sequelize from '../configs/database';

class Game extends Model {}

Game.init({
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
  },
}, {
  sequelize,
  timestamps: false,
  modelName: 'game',
  tableName: 'game'
});

export default Game;