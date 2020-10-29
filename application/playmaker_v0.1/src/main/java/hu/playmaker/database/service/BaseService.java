package hu.playmaker.database.service;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public abstract class BaseService {

    @PersistenceContext
    private EntityManager entityManager;

    public EntityManager getEntityManager() {
        return entityManager;
    }

    @Transactional
    public <T> T merge(T unmanaged) {
        return getEntityManager().merge(unmanaged);
    }

    @Transactional
    public void flush() {
        getEntityManager().flush();
    }

    @Transactional
    public <T> void delete(T model) {
        if (!entityManager.contains(model)) {
            model = entityManager.merge(model);
        }
        entityManager.remove(model);
    }

    @Transactional
    public <T> T mergeFlush(T unmanaged){
        T managed = getEntityManager().merge(unmanaged);
        getEntityManager().flush();
        return managed;
    }
}