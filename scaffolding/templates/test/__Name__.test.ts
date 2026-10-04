// Copy next to the file it tests, e.g. packages/domain/src/__name__/__Name__.test.ts
import { describe, expect, it } from "vitest";
import { create__Name__, type __Name__Id } from "./__Name__";

const id = "00000000-0000-0000-0000-000000000001" as __Name__Id;
const now = new Date("2026-01-01T00:00:00Z");

describe("create__Name__", () => {
  it("creates a __Name__ from valid input", () => {
    const result = create__Name__({ code: "3.1.1", name: " Strain gauges " }, id, now);
    expect(result).toEqual({
      ok: true,
      value: { id, code: "3.1.1", name: "Strain gauges", createdAt: now },
    });
  });

  it("accepts starter-kit codes", () => {
    expect(create__Name__({ code: "S.1.1", name: "Multimeter" }, id, now).ok).toBe(true);
  });

  it("rejects an empty name", () => {
    const result = create__Name__({ code: "3.1.1", name: "   " }, id, now);
    expect(result).toEqual({ ok: false, errors: ["name is required"] });
  });

  it("rejects a malformed BOM code", () => {
    const result = create__Name__({ code: "3..1", name: "Strain gauges" }, id, now);
    expect(result.ok).toBe(false);
  });
});
