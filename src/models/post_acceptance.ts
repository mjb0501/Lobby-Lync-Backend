import { DataTypes, Model } from 'sequelize';
import sequelize from '../config/database';

class PostAcceptance extends Model {}

PostAcceptance.init({
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
  userId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: 'user',
      key: 'id',
    },
    onDelete: 'CASCADE',
  },
}, {
  sequelize,
  modelName: 'post_acceptance',
  tableName: 'post_acceptance',
  timestamps: false,
  indexes: [
    {
      unique: true,
      fields: ['postId', 'userId'],
    },
  ],
});

export default PostAcceptance;