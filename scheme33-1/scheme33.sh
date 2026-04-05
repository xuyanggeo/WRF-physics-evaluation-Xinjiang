#!/bin/bash

#SBATCH -J scheme33-1			#作业名称，需要自定义
#SBATCH -p scheme33-1			#队列名称
#SBATCH -N 1			#使用的总节点数
#SBATCH -n 28			#使用的总核心数
#SBATCH --ntasks-per-node=28	#每个节点分配的任务数，一般为总核心数/总节点数，此值不能大于每个节点的最大核心数
#SBATCH -o log.%j		#标准输出日志，可自定义
#SBATCH -e log.%j			#标准错误日志，可自定义
#SBATCH --exclusive		#设置节点独占，非必须
#SBATCH -t 2:00:00		#设置作业最大运行时间，非必须
cd /public2/home/xuyang_haozhixin/XuYang/WRFV4/XINJIANG/scheme33-1









 cp $WPS_DIR/*exe .
cp $WPS_DIR/link_grib.csh .
cp ../../WPS/util/plotgrids_new.ncl ./
ln  -sf  $WPS_DIR/geogrid/GEOGRID.TBL
ln  -sf  $WPS_DIR/metgrid/METGRID.TBL
cp ~/XuYang/WRFV4/WPS/ungrib/Variable_Tables/Vtable.ECMWF ./Vtable
cp $WRF_DIR/run/*_DATA  .
cp $WRF_DIR/run/*.TBL   .
cp $WRF_DIR/run/*.txt   .
cp $WRF_DIR/run/*.tbl   .
cp $WRF_DIR/run/tr*     .
cp $WRF_DIR/run/ozone*  .
cp $WRF_DIR/run/CAMtr_volume_mixing_ratio  .
cp $WRF_DIR/main/wrf.exe  .
cp $WRF_DIR/run/*exe .
cp $WRF_DIR/run/*exe .
cp $WRF_DIR/run/*.bin .

####### 加载环境变量 ####### 

source ~/XuYang/.bashrc
####### 新建文件夹运行WPS ####### 
./link_grib.csh /public2/home/xuyang_haozhixin/XuYang/WRFV4/Data/era51960-1-* /public2/home/xuyang_haozhixin/XuYang/WRFV4/Data/era5sigle1960-1-*



./geogrid.exe

./ungrib.exe
./metgrid.exe



mpirun -np 28 ./real.exe
mpirun -np 28 ./wrf.exe
