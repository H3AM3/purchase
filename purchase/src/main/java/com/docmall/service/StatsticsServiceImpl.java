package com.docmall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import com.docmall.mapper.StatsticsMapper;

@Service
public class StatsticsServiceImpl implements StatsticsService {
	
	@Autowired
	private StatsticsMapper mapper;
	
	public List<ProductVO> searchProduct(OrderFormByVenderDTO dto) {
		return mapper.searchProduct(dto);
	}

	@Override
	public List<DepartmentVO> depSearchPopup(DepSearchDTO dto) {
		return mapper.depSearchPopup(dto);
	}

	@Override
	public List<Req_OrdersVO> getReqStatistics(StatisticsDTO dto) {
		return mapper.getReqStatistics(dto);
	}

	@Override
	public List<Tbl_ExportVO> getExportStatistics(StatisticsDTO dto) {
		return mapper.getExportStatistics(dto);
	}

	@Override
	public String getUpper_depName(DepartmentVO vo) {
		return mapper.getUpper_depName(vo);
	}

	@Override
	public List<Tbl_OrdersVO> getOrderStatistics(StatisticsDTO dto) {
		return mapper.getOrderStatistics(dto);
	}

	@Override
	public List<Tbl_ImportVO> getImportStatistics(StatisticsDTO dto) {
		return mapper.getImportStatistics(dto);
	}

	@Override
	public Monthly_StatisticsDTO getMonthlyReqStatistics(StatisticsDTO dto) {
		return mapper.getMonthlyReqStatistics(dto);
	}

	@Override
	public Monthly_StatisticsDTO getPrevYear(StatisticsDTO dto) {
		return mapper.getPrevYear(dto);
	}

	@Override
	public Monthly_StatisticsDTO getMonthlyOrderStatistics(StatisticsDTO dto) {
		return mapper.getMonthlyOrderStatistics(dto);
	}

	@Override
	public Monthly_StatisticsDTO getOrderPrevYear(StatisticsDTO dto) {
		return mapper.getOrderPrevYear(dto);
	}

	@Override
	public ProductVO getProductInfo(String product_code) {
		return mapper.getProductInfo(product_code);
	}

}
