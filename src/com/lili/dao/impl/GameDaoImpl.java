package com.lili.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.lili.dao.GameDao;
import com.lili.domain.GameClass;
import com.lili.domain.GameInfo;
import com.lili.domain.GameUser;

/**
 * @author lili
 *2019年1月11日
 * 
 */
public class GameDaoImpl extends HibernateDaoSupport implements GameDao{
	
	/**
	 * GameClass实体操作
	 */
	@Override
	public void insertGClass(GameClass gc) {
		this.getHibernateTemplate().save(gc);
		
	}

	@Override
	public void deleteGClass(GameClass gc) {
		this.getHibernateTemplate().delete(gc);
	}

	@Override
	public void updateGClass(GameClass gc) {
		this.getHibernateTemplate().update(gc);
	}

	@Override
	public GameClass isExistGC(GameClass gc) {
		String hql = "from GameClass where gameCname=?";
		List<GameClass> list = this.getHibernateTemplate().find(hql,gc.getGameCname());
		if(list.size()>0)
			return list.get(0);
		else
			return null;
	}

	@Override
	public GameClass findGClassById(int id) {
		return this.getHibernateTemplate().get(GameClass.class, id);
	}
	@Override
	public List<GameClass> findAllGameClass() {
		return this.getHibernateTemplate().find("from GameClass");
	}

	
	/**
	 * GameInfo实体操作
	 */
	@Override
	public void insertGameToClass(GameInfo gi) {
		this.getHibernateTemplate().save(gi);
	}

	@Override
	public void updateGameInfo(GameInfo gi) {
		this.getHibernateTemplate().update(gi);
	}

	@Override
	public void deleteGameInfo(GameInfo gi) {
		this.getHibernateTemplate().delete(gi);
	}

	@Override
	public GameInfo findGameById(int id) {
		return this.getHibernateTemplate().get(GameInfo.class, id);
	}

	@Override
	public GameInfo isExistGame(GameInfo gi) {
		String hql = "from GameInfo where name=?";
		List<GameInfo> list = this.getHibernateTemplate().find(hql,gi.getName());
		if(list.size()>0)
			return list.get(0);
		else
			return null;
	}
	
	/**
	 * GameUser实体操作
	 */
	@Override
	public List<GameUser> findGUserAll() {
		String hql="from GameUser";
		return this.getHibernateTemplate().find(hql);
	}
	
	@Override
	public List<GameInfo> findGameByClass(GameInfo gi) {
		String hql = "from GameInfo where gcId=?";
		return this.getHibernateTemplate().find(hql,gi.getGcId());
	}

	@Override
	public List<GameInfo> findAllGame() {
		return this.getHibernateTemplate().find("from GameInfo");
	}

	@Override
	public GameUser isExistGUser(int gameId,Integer gameUserId) {
		String hql="from GameUser where gameId=? and id=?";
		List<GameUser> list =  this.getHibernateTemplate().find(hql, gameId,gameUserId);
		if(list.size()>0)
			return list.get(0);
		else 
			return null;
	}

	@Override
	public GameUser findUserByName(String name) {
		String hql = "from GameUser where name=?";
		List<GameUser> list = this.getHibernateTemplate().find(hql, name);
		if(list.size()>0)
			return list.get(0);
		else
			return null;
	}

	@Override
	public void updateGUser(GameUser gu) {
		this.getHibernateTemplate().update(gu);
	}
	/**
	 * 分页
	 */

	@Override
	public List<GameUser> findByGId(GameUser gameUser) {
		String hql = "from GameUser where gameId = ?";
		return this.getHibernateTemplate().find(hql, gameUser.getGameId());
	}

	
}
