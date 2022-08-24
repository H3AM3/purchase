package com.docmall.service;

import java.util.List;

import com.docmall.domain.DepartmentVO;
import com.docmall.domain.ProductVO;
import com.docmall.domain.Req_OrdersVO;
import com.docmall.domain.Tbl_ExportVO;
import com.docmall.domain.Tbl_ImportVO;
import com.docmall.domain.Tbl_OrdersVO;
import com.docmall.dto.DepSearchDTO;
import com.docmall.dto.Monthly_StatisticsDTO;
import com.docmall.dto.OrderFormByVenderDTO;
import com.docmall.dto.StatisticsDTO;

public interface StatsticsService {

	public List<ProductVO> searchProduct(OrderFormByVenderDTO dto);
	public List<DepartmentVO> depSearchPopup(DepSearchDTO dto);
	public List<Req_OrdersVO> getReqStatistics(StatisticsDTO dto);
	public List<Tbl_ExportVO> getExportStatistics(StatisticsDTO dto);
	public String getUpper_depName(DepartmentVO vo);
	public List<Tbl_OrdersVO> getOrderStatistics(StatisticsDTO dto);
	public List<Tbl_ImportVO> getImportStatistics(StatisticsDTO dto);
	public Monthly_StatisticsDTO getMonthlyReqStatistics(StatisticsDTO dto);
	public Monthly_StatisticsDTO getPrevYear(StatisticsDTO dto);
	public Monthly_StatisticsDTO getMonthlyOrderStatistics(StatisticsDTO dto);
	public Monthly_StatisticsDTO getOrderPrevYear(StatisticsDTO dto);
	public ProductVO getProductInfo(String product_code);

}
