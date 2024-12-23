import { DataTypes, Model } from "sequelize";
import sequelize from '../configs/database';

class Platform extends Model {}

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

export default Platform;