// Base chung cho các mapper trong Data
abstract class DataMapper<M, E> {
  E toEntity(M model);

  M toModel(E entity);
}

// Base chung cho các mapper trong Domain
abstract class DomainMapper<R, P> {
  R paramsToRequest(P params);
}
