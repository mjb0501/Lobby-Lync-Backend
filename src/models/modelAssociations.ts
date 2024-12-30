import Post from './post';
import User from './user';
import Platform from './platform';
import Game from './game';
import PostPlatform from './post_platforms';

//This functions defines all of the necessary associations between models
//This function will be called in the index.js
const defineAssociations = () => {
    User.hasMany(Post, { foreignKey: 'userId', });
    Game.hasMany(Post, { foreignKey: 'gameId' });

    Post.belongsTo(User, { foreignKey: 'userId', as: 'User' });
    Post.belongsToMany(Platform, { 
        through: PostPlatform, 
        foreignKey: 'postId', 
        otherKey: 'platformId',
        as: 'Platforms',
    });
    Post.belongsTo(Game, { foreignKey: 'gameId', as: 'Game' });

    Platform.belongsToMany(Post, { through: PostPlatform, foreignKey: 'platformId', otherKey: 'postId' })
}

export default defineAssociations