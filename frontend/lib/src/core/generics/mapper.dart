/// Base chung cho các mapper
abstract class Mapper<D, E> {
  E modelToEntity(D dto);

  D entityToModel(E entity);
}
