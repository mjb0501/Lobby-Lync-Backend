import { DataTypes, Model, InferAttributes, InferCreationAttributes, CreationOptional } from "sequelize";
import sequelize from '../configs/database';
import Post from './post';

class Platform extends Model<InferAttributes<Platform>, InferCreationAttributes<Platform>> {
  declare id: CreationOptional<number>;
  declare name: string;
}

Platform.init({
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
    modelName: 'platform',
    tableName: 'platform'
});

//Platform.hasMany(Post, { foreignKey: 'platformId' });

export default Platform;