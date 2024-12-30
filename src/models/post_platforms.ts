import { DataTypes, Model } from 'sequelize';
import sequelize from '../configs/database';

class PostPlatform extends Model {}

PostPlatform.init({
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  postId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'post',
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
  modelName: 'post_platform',
  tableName: 'post_platform',
  timestamps: false,
  indexes: [
    {
      unique: true,
      fields: ['postId', 'platformId'],
    },
  ],
});

export default PostPlatform;