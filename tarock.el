;;; tarock.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 accraze
;;
;; Author: Andy Craze <https://github.com/accraze>
;; Maintainer: Andy Craze <accraze@gmail.com>
;; Created: May 29, 2022
;; Modified: May 29, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/accraze/tarock
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  This began as  a fork of tarot.el, changed to support the Daily One Card format
;;  and uses explanations from Labyrinthos
;;
;;; Code:
;;;
(require 'cl-lib)

(defvar swords-cards
  '(("Ace of Swords" . "Clarity, truth, decision making.")
    ("Two of Swords" . "Indecision, stalemate, avoidance.")
    ("Three of Swords" . "Heartbreak, betrayal, emotional pain.")
    ("Four of Swords" . "Rest, contemplation, healing.")
    ("Five of Swords" . "Defeat, failure, conflict.")
    ("Six of Swords" . "Moving forward, transition, leaving the past behind.")
    ("Seven of Swords" . "Deception, trickery, cunning.")
    ("Eight of Swords" . "Feeling trapped, helpless, limited.")
    ("Nine of Swords" . "Fear, anxiety, insomnia.")
    ("Ten of Swords" . "Pain, betrayal, defeat.")
    ("Page of Swords" . "Intelligence, communication, swiftness.")
    ("Knight of Swords" . "Boldness, assertiveness, directness.")
    ("Queen of Swords" . "Intelligence, independence, honesty.")
    ("King of Swords" . "Authority, power, rationality.")))

(defvar pentacles-cards
  '(("Ace of Pentacles" . "Opportunity, prosperity, abundance.")
    ("Two of Pentacles" . "Balance, adaptability, time management.")
    ("Three of Pentacles" . "Collaboration, teamwork, skilled work.")
    ("Four of Pentacles" . "Hoarding, possessiveness, materialism.")
    ("Five of Pentacles" . "Hardship, poverty, isolation.")
    ("Six of Pentacles" . "Charity, generosity, sharing.")
    ("Seven of Pentacles" . "Patience, perseverance, hard work.")
    ("Eight of Pentacles" . "Diligence, skill, craftsmanship.")
    ("Nine of Pentacles" . "Self-sufficiency, luxury, independence.")
    ("Ten of Pentacles" . "Wealth, family, inheritance.")
    ("Page of Pentacles" . "Manifestation, inspiration, new ideas.")
    ("Knight of Pentacles" . "Dependability, stability, practicality.")
    ("Queen of Pentacles" . "Nurturing, practicality, abundance.")
    ("King of Pentacles" . "Wealth, abundance, financial security.")))

(defvar cups-cards
  '(("Ace of Cups" . "Emotional new beginnings, new relationships.")
    ("Two of Cups" . "Love, connection, partnership.")
    ("Three of Cups" . "Celebration, friendship, community.")
    ("Four of Cups" . "Apathy, contemplation, reevaluation.")
    ("Five of Cups" . "Loss, grief, disappointment.")
    ("Six of Cups" . "Nostalgia, memories, childhood.")
    ("Seven of Cups" . "Opportunities, choices, decision-making.")
    ("Eight of Cups" . "Abandonment, disappointment, moving on.")
    ("Nine of Cups" . "Happiness, satisfaction, fulfillment.")
    ("Ten of Cups" . "Happy family life, emotional fulfillment.")
    ("Page of Cups" . "Creative inspiration, intuition, sensitivity.")
    ("Knight of Cups" . "Romance, charm, emotional depth.")
    ("Queen of Cups" . "Empathy, compassion, emotional support.")
    ("King of Cups" . "Emotional balance, maturity, calmness.")))

(defvar wands-cards
  '(("Ace of Wands" . "Inspiration, new beginnings, potential.")
    ("Two of Wands" . "Planning, making decisions, leaving home.")
    ("Three of Wands" . "Expansion, growth, opportunity.")
    ("Four of Wands" . "Celebration, harmony, homecoming.")
    ("Five of Wands" . "Conflict, competition, aggression.")
    ("Six of Wands" . "Victory, recognition, progress.")
    ("Seven of Wands" . "Perseverance, defensiveness, challenge.")
    ("Eight of Wands" . "Swiftness, progress, movement.")
    ("Nine of Wands" . "Resilience, courage, persistence.")
    ("Ten of Wands" . "Burden, responsibility, hard work.")
    ("Page of Wands" . "Inspiration, exploration, discovery.")
    ("Knight of Wands" . "Energy, passion, adventure.")
    ("Queen of Wands" . "Determination, confidence, creativity.")
    ("King of Wands" . "Leadership, vision, entrepreneurship.")))

(defvar minor-arcana-cards
   (append swords-cards
     wands-cards
     cups-cards
     pentacles-cards))

(defvar major-arcana-cards
  '(("The Fool" . "A new beginning, taking a chance, trust in the journey.")
    ("The Magician" . "Manifestation, skill, power, action.")
    ("The High Priestess" . "Intuition, mystery, secrets.")
    ("The Empress" . "Nurturing, motherly love, creativity, abundance.")
    ("The Emperor" . "Authority, stability, fatherly love.")
    ("The Hierophant" . "Tradition, spirituality, guidance.")
    ("The Lovers" . "Love, relationships, choices.")
    ("The Chariot" . "Victory, control, determination.")
    ("Strength" . "Bravery, inner strength, control of one's passions.")
    ("The Hermit" . "Solitude, introspection, inner guidance.")
    ("Wheel of Fortune" . "Cycles of change, destiny, life's ups and downs.")
    ("Justice" . "Fairness, truth, decision making.")
    ("The Hanged Man" . "Pausing, letting go, a different perspective.")
    ("Death" . "Transformation, endings, new beginnings.")
    ("Temperance" . "Moderation, balance, harmony.")
    ("The Devil" . "Temptation, addiction, materialism.")
    ("The Tower" . "Disaster, upheaval, unexpected events.")
    ("The Star" . "Hope, inspiration, renewal.")
    ("The Moon" . "Fear, insecurity, illusion.")
    ("The Sun" . "Success, happiness, positivity.")
    ("Judgment" . "Accountability, facing one's past, renewal.")
    ("The World" . "Completion, fulfillment, journey's end."))
  "List of tarot cards and their basic explanations.")

(defvar tarot-cards
  (append major-arcana-cards minor-arcana-cards))


(defun tarot-card-message ()
  "Selects a random tarot card from the `tarot-cards` list and returns a message."
  (let ((card (nth (random (length tarot-cards)) tarot-cards)))
    (format "Your tarot card for today is:\n%s\n%s" (car card) (cdr card))))

(defun org-insert-journal-entry (entry)
  "Inserts the given ENTRY as an Org journal entry."
  (save-excursion
    (end-of-buffer)
    (newline)
    (insert "* " (format-time-string "%Y-%m-%d") "\n")
    (insert "** Tarot Card\n")
    (insert entry)
    (org-mode)))

(defun org-insert-tarot-card-journal-entry ()
  "Inserts the tarot card message as an Org journal entry."
  (interactive)
  (let ((entry (tarot-card-message)))
    (org-insert-journal-entry entry)))

(defun get-tarot-card-message ()
  "Returns the tarot card message."
  (tarot-card-message))

(defun tarot-card ()
  "Return a random tarot card with a basic explanation."
  (let* ((card (nth (random (length tarot-cards)) tarot-cards))
         (name (car card))
         (explanation (cdr card)))
    (format "%s: %s" name explanation)))

(provide 'tarock)
;;; tarock.el ends here
