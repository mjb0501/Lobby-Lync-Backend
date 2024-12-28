import { DataTypes, Model, InferAttributes, InferCreationAttributes, CreationOptional } from 'sequelize';
import sequelize from '../configs/database';
import User from './user';
import Platform from './platform';
import Game from './game';

class Post extends Model<InferAttributes<Post>, InferCreationAttributes<Post>> {
  declare id: CreationOptional<number>;
  declare userId: number;
  declare platformId: number;
  declare gameId: number;
  declare description: string;
  declare createdAt: CreationOptional<Date>;
  declare User?: User;
  declare Platform?: Platform;
  declare Game?: Game;
}

Post.init({
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
  gameId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'game',
      key: 'id',
    },
    onDelete: 'CASCADE',
  },
  description: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  createdAt: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
}, {
  sequelize,
  timestamps: false,
  modelName: 'post',
  tableName: 'post',
});

//associations
// Post.belongsTo(User, { foreignKey: 'userId' });
// Post.belongsTo(Platform, { foreignKey: 'platformId' });
// Post.belongsTo(Game, { foreignKey: 'gameId' });

export default Post;