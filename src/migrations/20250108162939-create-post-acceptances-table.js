'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('post_acceptance', {
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
      userId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'user', // The table name for the User model
          key: 'id',
        },
        onDelete: 'CASCADE',
      },
    });

    // Create a unique index for the composite key (postId, userId)
    await queryInterface.addConstraint('post_acceptance', {
      fields: ['postId', 'userId'],
      type: 'unique',
      name: 'unique_post_acceptance_constraint',
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.dropTable('post_acceptance');
  }
};
