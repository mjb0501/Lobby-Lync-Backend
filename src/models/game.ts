import { DataTypes, Model, InferAttributes, InferCreationAttributes, CreationOptional, NonAttribute, Association } from "sequelize";
import sequelize from '../config/database';
import Platform from './platform'

class Game extends Model<InferAttributes<Game, { omit: 'platforms' }>, InferCreationAttributes<Game, { omit: 'platforms' }>> {
  declare id: CreationOptional<number>;
  declare name: string;

  declare platforms?: NonAttribute<Platform[]>;

  declare static associations: {
    platforms: Association<Game, Platform>;
  };
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