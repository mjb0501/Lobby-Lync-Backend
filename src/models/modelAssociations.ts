import Post from './post';
import User from './user';
import Platform from './platform';
import Game from './game';
import PostPlatform from './post_platforms';
import GamePlatform from './game_platforms';

//This functions defines all of the necessary associations between models
//This function will be called in the index.js
const defineAssociations = () => {
    User.hasMany(Post, { foreignKey: 'userId', });

    Game.hasMany(Post, { foreignKey: 'gameId' });
    Game.belongsToMany(Platform, {
        through: GamePlatform,
        foreignKey: 'gameId',
        otherKey: 'platformId',
        as: 'platforms'
    })

    Post.belongsTo(User, { foreignKey: 'userId', as: 'User' });
    Post.belongsToMany(Platform, { 
        through: PostPlatform, 
        foreignKey: 'postId', 
        otherKey: 'platformId',
        as: 'platforms',
    });
    Post.belongsTo(Game, { foreignKey: 'gameId', as: 'Game' });

    Platform.belongsToMany(Post, { through: PostPlatform, foreignKey: 'platformId', otherKey: 'postId' });
    Platform.belongsToMany(Game, { through: GamePlatform, foreignKey: 'platformId', otherKey: 'gameId' });
}

export default defineAssociations