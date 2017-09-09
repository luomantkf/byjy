package com.jy.util;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.InputStream;

/**
 * Created by Administrator on 2017/2/13.
 */
public class DbUtil {
    public  SqlSession getSqlSession() throws Exception{
        // mybatis�����ļ�
        String resource = "SqlMapConfig.xml";
        // �õ������ļ���
        InputStream inputStream = Resources.getResourceAsStream(resource);

        // �����Ự����������mybatis�������ļ���Ϣ
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder()
                .build(inputStream);
        return sqlSessionFactory.openSession();


    }
    public void closeSqlSession(SqlSession sqlSession){
        sqlSession.close();
    }
}
