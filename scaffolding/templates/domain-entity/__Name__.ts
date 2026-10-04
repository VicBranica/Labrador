/**
 * __Name__ — one line on what this entity is in the Labrador domain.
 *
 * Copy to packages/domain/src/__name__/__Name__.ts.
 * Domain code only: no database, network or framework imports.
 */

export type __Name__Id = string & { readonly __brand: "__Name__Id" };

export interface __Name__ {
  readonly id: __Name__Id;
  /** BOM code: bench.category.item, e.g. "3.1.3"; the starter kit uses "S". */
  readonly code: string;
  readonly name: string;
  readonly createdAt: Date;
}

export interface Create__Name__Input {
  code: string;
  name: string;
}

/** Move to packages/shared once a second entity needs it. */
export type Result<T> = { ok: true; value: T } | { ok: false; errors: string[] };

const BOM_CODE = /^(S|[1-7])(\.\d+){0,2}$/;

/** Rules every __Name__ must satisfy. Add the entity's own rules here. */
export function validate__Name__(input: Create__Name__Input): string[] {
  const errors: string[] = [];
  if (!BOM_CODE.test(input.code)) errors.push(`invalid BOM code: "${input.code}"`);
  if (input.name.trim() === "") errors.push("name is required");
  return errors;
}

/** The id and clock come in from the caller, so this stays pure and testable. */
export function create__Name__(
  input: Create__Name__Input,
  id: __Name__Id,
  now: Date,
): Result<__Name__> {
  const errors = validate__Name__(input);
  if (errors.length > 0) return { ok: false, errors };
  return { ok: true, value: { id, code: input.code, name: input.name.trim(), createdAt: now } };
}
