json.candidate do |json|
  json.partial! 'candidates/candidate', candidate: current_candidate
end