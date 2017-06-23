INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '一、营业收入', '1', 'AS(6001)+AS(6051)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '        减：营业成本', '2', 'AS(6401)+AS(6402)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '                营业税金及附加', '3', 'AS(6403)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '                销售费用', '4', 'AS(6601)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '                管理费用', '5', 'AS(6602)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '                财务费用', '6', 'AS(6603)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '二、营业利润（亏损以“－”号填列）    ', '7', 'DS(1,-2,-3,-4,-5,-6)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '        加：营业外收入', '8', 'AS(6301)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '        减：营业外支出', '9', 'AS(6711)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '三、利润总额（亏损总额以“－”号填列）', '10', 'DS(7,8,-9)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '        减：所得税费用', '11', 'AS(6801)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '四、净利润（净亏损以“－”号填列）', '12', 'DS(10,-11)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '五、收益率', '13', '', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '        经营收益率(%)', '14', 'DS(7)/DS(2,3,4,5,6)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');
INSERT INTO `tbd_fiscal_business_formula`(FID,FITEM,FNUMBER,FFORMULA,DEPTID,FORG_ID,FACC_ID,FUPDATE_TIME) VALUES (':FID', '        净收益率(%)', '15', 'DS(12)/DS(2,3,4,5,6,9,11)', ':DEPTID', ':FORG_ID', ':FACC_ID', ':FCREATE_TIME');