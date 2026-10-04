// Copy to apps/web/src/features/__name__/components/__Name__View.tsx
import { useTranslations } from "next-intl";

export interface __Name__ViewProps {
  /** Overrides the translated title. */
  title?: string;
}

export function __Name__View({ title }: __Name__ViewProps) {
  const t = useTranslations("__name__");

  return (
    <section aria-labelledby="__name__-heading">
      <h1 id="__name__-heading">{title ?? t("title")}</h1>
      <p>{t("description")}</p>
    </section>
  );
}
