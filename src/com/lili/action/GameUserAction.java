package com.lili.action;

import java.util.List;

import com.lili.domain.GameInfo;
import com.lili.domain.GameUser;
import com.lili.domain.Page;
import com.lili.service.GameService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * @author lili
 *2019年1月12日
 * 
 */
public class GameUserAction extends ActionSupport implements ModelDriven<GameUser>{
	
	//为ModelDriven提供GameUser对象
	GameUser gameUser = new GameUser();
	@Override
	public GameUser getModel() {
		return gameUser;
	}
	//依赖注入业务层
	private GameService gameService;
	public void setGameService(GameService gameService) {
		this.gameService = gameService;
	}
	
	/**
	 * 分页显示
	 */
	private String currentPage;                  //前端传来的当前页码
	public String getCurrentPage() {
		return currentPage;
	}
 
	public void setCurrentPage(String currentPage) {
		this.currentPage = currentPage;
	}
	public void findPage(List list) {
		//得到当前页
		String currentPage = this.currentPage;
		if(currentPage == null)
			currentPage = "1";
		int pageNum = Integer.parseInt(currentPage);
		Page<GameUser> page = new Page<GameUser>();
		page.setBigList(list); //设置 要分页的集合
		page.setCurrentPage(pageNum);
		page.setPageRow(10);
		ActionContext.getContext().getSession().put("page", page);
	}
	public String findByGId() {
		List<GameUser> list = (List<GameUser>) this.gameService.findByGId(gameUser);
		this.findPage(list);
		ActionContext.getContext().getSession().put("gameId", gameUser.getGameId());
		return "findByGIdUI";
	}
	public String findAll() {
		List<GameUser> list = (List<GameUser>) this.gameService.findGUserAll();
		this.findPage(list);
		return "findAll";
	}
}
