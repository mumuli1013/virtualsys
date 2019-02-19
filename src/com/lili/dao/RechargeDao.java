package com.lili.dao;

import java.util.Date;
import java.util.List;
import com.lili.domain.RechargeOrder;

/**
 * @author lili
 *2019年1月15日
 * 
 */
public interface RechargeDao {
	//实体RechargeOrder
	RechargeOrder findByNo(String outTradeNo);  //用于notify_url.jsp
	void insertROrder(RechargeOrder rechargeOrder);
	void deleteROrder(RechargeOrder rechargeOrder);
	void updateROrder(RechargeOrder rechargeOrder);
	
	//分页显示
	List<RechargeOrder> findById(RechargeOrder rechargeOrder);
	List<RechargeOrder> findByIS(RechargeOrder rechargeOrder);
	List<RechargeOrder> findAll();
	List<RechargeOrder> findAllByStatus(RechargeOrder rechargeOrder);
	List<RechargeOrder> findByTime(String startTime,String endTime,RechargeOrder rechargeOrder);
	List<RechargeOrder> findAllByTime(String startTime,String endTime);
}
