'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('game', [
      { id: 1, name: 'Call of Duty' },
      { id: 2, name: 'Minecraft' },
      { id: 3, name: 'Roblox' },
      { id: 4, name: 'Fortnite' },
      { id: 5, name: 'Call of Duty 2' },
    ]);
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.bulkDelete('game', null, {});
  },
};
