import { DataTypes, Model, InferAttributes, InferCreationAttributes, CreationOptional } from "sequelize";
import sequelize from '../configs/database';

class Game extends Model<InferAttributes<Game>, InferCreationAttributes<Game>> {
  declare id: CreationOptional<number>;
  declare name: string;
}

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

//Game.hasMany(Post, { foreignKey: 'gameId' });

export default Game;