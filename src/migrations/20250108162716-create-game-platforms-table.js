'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('game_platform', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
      },
      gameId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'game', // The table name for the Game model
          key: 'id',
        },
        onDelete: 'CASCADE',
      },
      platformId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'platform', // The table name for the Platform model
          key: 'id',
        },
        onDelete: 'CASCADE',
      },
    });

    // Create a unique index for the composite key (gameId, platformId)
    await queryInterface.addConstraint('game_platform', {
      fields: ['gameId', 'platformId'],
      type: 'unique',
      name: 'unique_game_platform_constraint',
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.dropTable('game_platform');
  }
};
