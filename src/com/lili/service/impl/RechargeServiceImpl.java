package com.lili.service.impl;

import java.util.Date;
import java.util.List;

import com.lili.dao.RechargeDao;
import com.lili.domain.Page;
import com.lili.domain.RechargeOrder;
import com.lili.service.RechargeService;

/**
 * @author lili
 *2019年1月21日
 * 
 */
public class RechargeServiceImpl implements RechargeService{
	private RechargeDao rechargeDao;

	public void setRechargeDao(RechargeDao rechargeDao) {
		this.rechargeDao = rechargeDao;
	}

	@Override
	public void addRO(RechargeOrder rechargeOrder) {
		Date currTime = new Date();
		rechargeOrder.setCreateTime(currTime);
		rechargeOrder.setUpdateTime(currTime);
		rechargeOrder.setVAmount(rechargeOrder.getRmbAmount()*10);
		rechargeOrder.setStatus(2);
		this.rechargeDao.insertROrder(rechargeOrder);
	}

	@Override
	public RechargeOrder findByNo(String outTradeNo) {
		return this.rechargeDao.findByNo(outTradeNo);
	}

	@Override
	public void deleteROrder(RechargeOrder rechargeOrder) {
		this.rechargeDao.deleteROrder(rechargeOrder);
	}

	@Override
	public void updateROrder(RechargeOrder rechargeOrder) {
		this.rechargeDao.updateROrder(rechargeOrder);
	}
	/**
	 * 分页显示
	 */
	@Override
	public List<RechargeOrder> findById(RechargeOrder rechargeOrder) {
		return  this.rechargeDao.findById(rechargeOrder);
	}

	@Override
	public List<RechargeOrder> findByIs(RechargeOrder rechargeOrder) {
		return this.rechargeDao.findByIS(rechargeOrder);
	}

	@Override
	public List<RechargeOrder> findAll() {
		return this.rechargeDao.findAll();
	}

	@Override
	public List<RechargeOrder> findAllByStatus(RechargeOrder rechargeOrder) {
		return this.rechargeDao.findAllByStatus(rechargeOrder);
	}

	@Override
	public List<RechargeOrder> findByTime(String startTime,String endTime,RechargeOrder rechargeOrder) {
		return this.rechargeDao.findByTime(startTime, endTime,rechargeOrder);
	}

	@Override
	public List<RechargeOrder> findAllByTime(String startTime, String endTime) {
		return this.rechargeDao.findAllByTime(startTime, endTime);
	}

}
