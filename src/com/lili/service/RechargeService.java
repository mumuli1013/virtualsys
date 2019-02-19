package com.lili.service;

import java.util.Date;
import java.util.List;
import com.lili.domain.RechargeOrder;

/**
 * @author lili
 *2019年1月21日
 * 
 */
public interface RechargeService {
	//RechargeOrder
	void addRO(RechargeOrder rechargeOrder);
	RechargeOrder findByNo(String outTradeNo);
	void deleteROrder(RechargeOrder rechargeOrder);
	void updateROrder(RechargeOrder rechargeOrder);
	
	//分页显示
	List<RechargeOrder> findById(RechargeOrder rechargeOrder);
	List<RechargeOrder> findByIs(RechargeOrder rechargeOrder);
	List<RechargeOrder> findAll();
	List<RechargeOrder> findAllByStatus(RechargeOrder rechargeOrder);
	List<RechargeOrder> findByTime(String startTime,String endTime,RechargeOrder rechargeOrder);
	List<RechargeOrder> findAllByTime(String startTime,String endTime);
}
