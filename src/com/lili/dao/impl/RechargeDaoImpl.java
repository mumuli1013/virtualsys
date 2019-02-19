package com.lili.dao.impl;

import java.util.Date;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.lili.dao.RechargeDao;
import com.lili.domain.Pay;
import com.lili.domain.RechargeOrder;

/**
 * @author lili
 *2019年1月21日
 * 
 */
public class RechargeDaoImpl extends HibernateDaoSupport implements RechargeDao{
	/**
	 * 以订单号查询订单
	 */
	@Override
	public RechargeOrder findByNo(String outTradeNo) {
		String hql = "from RechargeOrder where outTradeNo = ?";
		List<RechargeOrder> list = this.getHibernateTemplate().find(hql,outTradeNo);
		if(list.size()>0)
			return list.get(0);
		else
			return null;
	}
	@Override
	public void insertROrder(RechargeOrder rechargeOrder) {
		this.getHibernateTemplate().save(rechargeOrder);
	}

	@Override
	public void deleteROrder(RechargeOrder rechargeOrder) {
		this.getHibernateTemplate().delete(rechargeOrder);
	}

	@Override
	public void updateROrder(RechargeOrder rechargeOrder) {
		this.getHibernateTemplate().update(rechargeOrder);
	}
	
	/**
	 * 分页显示
	 */
	//查询个人充值订单
	@Override
	public List<RechargeOrder> findById(RechargeOrder rechargeOrder) {
		String hql = "from RechargeOrder where userId = ? ";
		List<RechargeOrder> list = this.getHibernateTemplate().find(hql,rechargeOrder.getUserId());
		return list;
	}
	//查询个人不同状态的充值订单
	@Override
	public List<RechargeOrder> findByIS(RechargeOrder rechargeOrder) {
		String hql = "from RechargeOrder where userId = ? and status = ?";
		List<RechargeOrder> list = this.getHibernateTemplate().find(hql,rechargeOrder.getUserId(),rechargeOrder.getStatus());
		return list;
	}
	//查询所有订单
	@Override
	public List<RechargeOrder> findAll() {
		String hql = "from RechargeOrder";
		List<RechargeOrder> list = this.getHibernateTemplate().find(hql);
		return list;
	}
	//查询不同状态下所有订单
	@Override
	public List<RechargeOrder> findAllByStatus(RechargeOrder rechargeOrder) {
		String hql = "from RechargeOrder where status = ?";
		List<RechargeOrder> list = this.getHibernateTemplate().find(hql,rechargeOrder.getStatus());
		return list;
	}
	/**
	 * 时间查询订单
	 */
	@Override
	public List<RechargeOrder> findByTime(String startTime, String endTime,RechargeOrder rechargeOrder) {
		String hql = "from RechargeOrder where DATE_FORMAT(createTime,'%Y-%m-%d')>=? and DATE_FORMAT(createTime,'%Y-%m-%d')<=? and userId=?";
		List<RechargeOrder> list = this.getHibernateTemplate().find(hql,startTime,endTime,rechargeOrder.getUserId());
		return list;
	}
	@Override
	public List<RechargeOrder> findAllByTime(String startTime, String endTime) {
		String hql = "from RechargeOrder where DATE_FORMAT(createTime,'%Y-%m-%d')>=? and DATE_FORMAT(createTime,'%Y-%m-%d')<=?";
		List<RechargeOrder> list = this.getHibernateTemplate().find(hql,startTime,endTime);
		return list;
	}
}
