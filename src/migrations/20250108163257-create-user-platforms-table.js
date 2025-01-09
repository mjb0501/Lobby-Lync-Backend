'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.createTable('user_platform', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
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
      platformId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
          model: 'platform', // The table name for the Platform model
          key: 'id',
        },
        onDelete: 'CASCADE',
      },
      platformUsername: {
        type: Sequelize.STRING,
        allowNull: false,
      },
    });

    // Add a unique constraint for the composite key (userId, platformId)
    await queryInterface.addConstraint('user_platform', {
      fields: ['userId', 'platformId'],
      type: 'unique',
      name: 'unique_user_platform_constraint',
    });
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.dropTable('user_platform');
  }
};
