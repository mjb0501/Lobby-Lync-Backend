'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('platform', [
      { id: 1, name: 'Xbox' },
      { id: 2, name: 'Playstation' },
      { id: 3, name: 'PC' },
      { id: 4, name: 'Switch' },
    ]);
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.bulkDelete('platform', null, {});
  }
};
