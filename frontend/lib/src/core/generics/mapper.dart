// Base chung cho các mapper trong Data
abstract class DataMapper<M, E> {
  E toEntity(M model);

  M toModel(E entity);
}
