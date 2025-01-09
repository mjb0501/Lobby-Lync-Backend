'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('game_platform', [
      { gameId: 1, platformId: 1 },
      { gameId: 1, platformId: 2 },
      { gameId: 1, platformId: 3 },
      { gameId: 2, platformId: 1 },
      { gameId: 2, platformId: 2 },
      { gameId: 2, platformId: 3 },
      { gameId: 2, platformId: 4 },
      { gameId: 3, platformId: 3 },
      { gameId: 4, platformId: 1 },
      { gameId: 4, platformId: 2 },
      { gameId: 4, platformId: 3 },
      { gameId: 4, platformId: 4 },
      { gameId: 5, platformId: 1 },
      { gameId: 5, platformId: 2 },
      { gameId: 5, platformId: 3 },
    ]);
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.bulkDelete('game_platform', null, {});
  }
};
