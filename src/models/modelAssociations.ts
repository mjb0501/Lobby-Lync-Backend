import Post from './post';
import User from './user';
import Platform from './platform';
import Game from './game';

//This functions defines all of the necessary associations between models
//This function will be called in the index.js
const defineAssociations = () => {
    User.hasMany(Post, { foreignKey: 'userId', });
    Platform.hasMany(Post, { foreignKey: 'platformId' });
    Game.hasMany(Post, { foreignKey: 'gameId' });

    Post.belongsTo(User, { foreignKey: 'userId', as: 'User' });
    Post.belongsTo(Platform, { foreignKey: 'platformId', as: 'Platform' });
    Post.belongsTo(Game, { foreignKey: 'gameId', as: 'Game' });
}

export default defineAssociations