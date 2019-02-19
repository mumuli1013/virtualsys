package com.lili.service.impl;

import java.util.Date;
import java.util.List;

import com.lili.dao.GameDao;
import com.lili.domain.GameClass;
import com.lili.domain.GameInfo;
import com.lili.domain.GameUser;
import com.lili.service.GameService;

/**
 * @author lili
 *2019年1月12日
 * 
 */
public class GameServiceImpl implements GameService {
	private GameDao gameDao;
	
	public void setGameDao(GameDao gameDao) {
		this.gameDao = gameDao;
	}

	@Override
	public void insertGClass(GameClass gc) {
		Date currentTime = new Date();
		gc.setCreateTime(currentTime);
		gc.setStatus(1);
		this.gameDao.insertGClass(gc);
	}

	@Override
	public void deleteGClass(GameClass gc) {
		this.gameDao.deleteGClass(gc);
	}

	@Override
	public void updateGClass(GameClass gc) {
		Date currentTime = new Date();
		gc.setUpdateTime(currentTime);
		this.gameDao.updateGClass(gc);
	}

	@Override
	public GameClass isExistGC(GameClass gc) {
		return this.gameDao.isExistGC(gc);
	}

	@Override
	public GameClass findGClassById(int id) {
		return this.gameDao.findGClassById(id);
	}
	
	@Override
	public List<GameClass> findAllGameClass() {
		return this.gameDao.findAllGameClass();
	}
	
	@Override
	public void insertGameToClass(GameInfo gi) {
		Date currentTime = new Date();
		gi.setCreateTime(currentTime);
		this.gameDao.insertGameToClass(gi);
	}

	@Override
	public void updateGameInfo(GameInfo gi) {
		Date currentTime = new Date();
		gi.setUpdateTime(currentTime);
		this.gameDao.updateGameInfo(gi);
	}

	@Override
	public void deleteGameInfo(GameInfo gi) {
		this.gameDao.deleteGameInfo(gi);
	}

	@Override
	public GameInfo findGameById(int id) {
		return this.gameDao.findGameById(id);
	}

	@Override
	public GameInfo isExistGame(GameInfo gi) {
		return this.gameDao.isExistGame(gi);
	}

	@Override
	public List<GameUser> findGUserAll() {
		return this.gameDao.findGUserAll();
	}
	
	@Override
	public List<GameInfo> findGameByClass(GameInfo gi) {
		return this.gameDao.findGameByClass(gi);
	}

	@Override
	public List<GameInfo> findAllGame() {
		return this.gameDao.findAllGame();
	}

	@Override
	public GameUser isExistGUser(int gameId,Integer gameUserId) {
		return this.gameDao.isExistGUser(gameId,gameUserId);
	}

	@Override
	public GameUser findUserByName(String name) {
		return this.gameDao.findUserByName(name);
	}

	@Override
	public void updateGUser(GameUser gu) {
		Date currTime = new Date();
		gu.setUpdateTime(currTime);
		this.gameDao.updateGUser(gu);
	}

	/**
	 * 分页
	 */

	@Override
	public List<GameUser> findByGId(GameUser gameUser) {
		return this.gameDao.findByGId(gameUser);
	}

}
