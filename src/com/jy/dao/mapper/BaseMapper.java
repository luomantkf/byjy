package com.jy.dao.mapper;

import java.util.List;

/**
 * Created by Administrator on 2017/2/14.
 */
public interface BaseMapper {
    //����
    Integer insert(Object obj);
    //�༭
    Integer update(Object obj);
    //ɾ��
    Integer delete(Object obj);
    //��ѯ
    Object select(Object obj);
    //��ҳ������ѯ
    Integer pageRows(Object obj);
    //��ҳ����
    List<Object> pageList(Object obj);
}
