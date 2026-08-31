import { CheckIcon } from "./CheckIcon";
import type { QuickAnswer } from "@/lib/listings";

export function QuickAnswersCard({ answers }: { answers: QuickAnswer[] }) {
  if (answers.length === 0) return null;

  return (
    <div className="mt-6">
      <h2 className="font-heading text-lg font-bold text-stone-800">Quick Answers</h2>
      <div className="mt-3 flex flex-col gap-3">
        {answers.map((qa) => (
          <div
            key={qa.label}
            className="flex items-center justify-between gap-3 rounded-2xl border border-amber-950/20 bg-amber-900 p-4 shadow-md"
          >
            <div className="flex items-center gap-2 text-white">
              <CheckIcon className="h-5 w-5 shrink-0 text-emerald-300" />
              <span className="text-sm font-semibold">{qa.label}</span>
            </div>
            <span className="text-right text-sm text-amber-100">{qa.value}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
