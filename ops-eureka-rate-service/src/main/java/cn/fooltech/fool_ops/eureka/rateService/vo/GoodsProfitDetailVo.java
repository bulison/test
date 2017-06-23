package cn.fooltech.fool_ops.eureka.rateService.vo;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by admin on 2017/3/29.
 */
public class GoodsProfitDetailVo {
    //仓库单据ID
    private String billId;
    //货品ID
    private String goodsId;
    //货品属性ID
    private String SpecId;
    //货品编号
    private String goodsCode;
    //货品名称
    private String goodsName;
    //货品属性
    private String SpecName;
    //记账单位ID
    private String accountUnitId;
    //记账单位
    private String accountUnitName;
    //单据日期
    private Date billDate;
    //单据类型
    private String billType;
    //单号
    private String billCode;
    //客户ID
    private String customerID;
    //客户名称
    private String customerName;
    //销售数量
    private BigDecimal accountQuentity;
    //销售金额
    private BigDecimal accountAmount;
    //货品成本
    private BigDecimal costAmount;
    //利润
    private BigDecimal profit;
    //利润率
    private BigDecimal profitRate;

    public String getBillId() {return billId;}

    public void setBillId(String billId) {this.billId = billId;}

    public String getGoodsId() {return goodsId;}

    public void setGoodsId(String goodsId) {this.goodsId = goodsId;}

    public String getSpecId() {return SpecId;}

    public void setSpecId(String specId) {SpecId = specId;}

    public String getGoodsCode() {return goodsCode;}

    public void setGoodsCode(String goodsCode) {this.goodsCode = goodsCode;}

    public String getGoodsName() {return goodsName;}

    public void setGoodsName(String goodsName) {this.goodsName = goodsName;}

    public String getSpecName() {return SpecName;}

    public void setSpecName(String specName) {SpecName = specName;}

    public String getAccountUnitId() {return accountUnitId;}

    public void setAccountUnitId(String accountUnitId) {this.accountUnitId = accountUnitId;}

    public String getAccountUnitName() {return accountUnitName;}

    public void setAccountUnitName(String accountUnitName) {this.accountUnitName = accountUnitName;}

    public Date getBillDate() {return billDate;}

    public void setBillDate(Date billDate) {this.billDate = billDate;}

    public String getBillType() {return billType;}

    public void setBillType(String billType) {this.billType = billType;}

    public String getBillCode() {return billCode;}

    public void setBillCode(String billCode) {this.billCode = billCode;}

    public String getCustomerID() {return customerID;}

    public void setCustomerID(String customerID) {this.customerID = customerID;}

    public String getCustomerName() {return customerName;}

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public BigDecimal getAccountQuentity() {
        return accountQuentity;
    }

    public void setAccountQuentity(BigDecimal accountQuentity) {
        this.accountQuentity = accountQuentity;
    }

    public BigDecimal getAccountAmount() {
        return accountAmount;
    }

    public void setAccountAmount(BigDecimal accountAmount) {
        this.accountAmount = accountAmount;
    }

    public BigDecimal getCostAmount() {
        return costAmount;
    }

    public void setCostAmount(BigDecimal costAmount) {
        this.costAmount = costAmount;
    }

    public BigDecimal getProfit() {
        return profit;
    }

    public void setProfit(BigDecimal profit) {
        this.profit = profit;
    }

    public BigDecimal getProfitRate() {
        return profitRate;
    }

    public void setProfitRate(BigDecimal profitRate) {
        this.profitRate = profitRate;
    }
}
