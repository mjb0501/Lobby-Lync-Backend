import { 
  DataTypes, 
  Model, 
  InferAttributes, 
  InferCreationAttributes, 
  CreationOptional,
  BelongsToManyAddAssociationsMixin,
  NonAttribute,
  Association,
 } from 'sequelize';
import sequelize from '../config/database';
import User from './user';
import PostPlatform from './post_platforms';
import Platform from './platform';
import Game from './game';

class Post extends Model<InferAttributes<Post>, InferCreationAttributes<Post>> {
  declare id: CreationOptional<number>;
  declare userId: number;
  declare gameId: number;
  declare description: string;
  declare createdAt: CreationOptional<Date>;

  //Used to declare the method (This is only necessary if using typescript)
  declare addPlatforms: BelongsToManyAddAssociationsMixin<Platform, number>;

  //Nonattribute marks properties that are not a part of the database but are added tyrough association
  declare User?: NonAttribute<User>;
  declare platforms?: NonAttribute<Platform[]>;
  declare Game?: NonAttribute<Game>;

  //declarations of the associations for typescript to work effectively
  declare static associations: {
    User: Association<Post, User>;
    platforms: Association<Post, Platform>
    Game: Association<Post, Game>;
  };
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

export default Post;