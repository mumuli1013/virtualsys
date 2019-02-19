package com.lili.dao.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.lili.dao.PayDao;
import com.lili.domain.Pay;

/**
 * @author lili
 *2019年1月15日
 * 
 */
public class PayDaoImpl extends HibernateDaoSupport implements PayDao {
	@Override
	public void createPayOrder(Pay pay) {
		this.getHibernateTemplate().save(pay);
	}

	@Override
	public List<Pay> findById(Pay pay) {
		String hql = "from Pay where userId=?";
		return this.getHibernateTemplate().find(hql,pay.getUserId());
	}

	@Override
	public List<Pay> findByIS(Pay pay) {
		String hql = "from Pay where userId=? and status=?";
		return this.getHibernateTemplate().find(hql,pay.getUserId(),pay.getStatus());
	}

	@Override
	public List<Pay> findAll() {
		String hql = "from Pay";
		return this.getHibernateTemplate().find(hql);
	}

	@Override
	public List<Pay> findAllByStatus(Pay pay) {
		String hql = "from Pay where status=?";
		return this.getHibernateTemplate().find(hql,pay.getStatus());
	}

	@Override
	public List<Pay> findByTime(String startTime, String endTime, Pay pay) {
		String hql = "from Pay where DATE_FORMAT(payTime,'%Y-%m-%d')>=? and DATE_FORMAT(payTime,'%Y-%m-%d')<=? and userId=?";
		return this.getHibernateTemplate().find(hql,startTime,endTime,pay.getUserId());
	}

	@Override
	public List<Pay> findAllByTime(String startTime, String endTime) {
		String hql = "from Pay where DATE_FORMAT(payTime,'%Y-%m-%d')>=? and DATE_FORMAT(payTime,'%Y-%m-%d')<=?";
		return this.getHibernateTemplate().find(hql,startTime,endTime);
	}

	@Override
	public List<Pay> findByGameId(Pay pay) {
		String hql = "from Pay where gameId = ?";
		return this.getHibernateTemplate().find(hql, pay.getGameId());
	}

	@Override
	public List<Pay> findGIdByTime(String startTime,String endTime,Pay pay) {
		String hql = "from Pay where DATE_FORMAT(payTime,'%Y-%m-%d')>=? and DATE_FORMAT(payTime,'%Y-%m-%d')<=? and gameId=?";
		return this.getHibernateTemplate().find(hql,startTime,endTime,pay.getGameId());
	}

	@Override
	public List<Pay> findGIdByStatus(Pay pay) {
		String hql = "from Pay where gameId = ? and status = ?";
		return this.getHibernateTemplate().find(hql, pay.getGameId(),pay.getStatus());
	}
}
