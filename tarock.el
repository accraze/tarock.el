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

(defvar tarot-cards
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

(defun tarot-card ()
  "Return a random tarot card with a basic explanation."
  (let* ((card (nth (random (length tarot-cards)) tarot-cards))
         (name (car card))
         (explanation (cdr card)))
    (format "%s: %s" name explanation)))

(provide 'tarot-card)
;;; tarock.el ends here
