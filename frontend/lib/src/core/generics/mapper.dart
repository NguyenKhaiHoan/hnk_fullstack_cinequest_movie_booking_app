/// Base chung cho các mapper trong Data
abstract class DataMapper<M, E> {
  E modelToEntity(M model);

  M entityToModel(E entity);
}

/// Base chung cho các mapper trong Domain
abstract class DomainMapper<R, P> {
  R paramsToRequest(P params);
}
