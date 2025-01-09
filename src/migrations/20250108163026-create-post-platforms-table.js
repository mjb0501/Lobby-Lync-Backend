'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('post_platform', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
      },
      postId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'post', // The table name for the Post model
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

    // Create a unique index for the composite key (postId, platformId)
    await queryInterface.addConstraint('post_platform', {
      fields: ['postId', 'platformId'],
      type: 'unique',
      name: 'unique_post_platform_constraint',
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.dropTable('post_platform');
  }
};
