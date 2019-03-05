# This is the class used to check the passed in argument.
class Checker
  # Returns true if and only if:
  # 1. There are three arguments
  # 2. All of them integer
  # 3. The second and third argument is non-positive
  # Returns false otherwise
  # If any errors occur such as nil, just return false and exit
  def check_args(args)
    args.count == 3 && Integer(args[0]) && Integer(args[1]) >= 0 && Integer(args[2]) >= 0
  rescue StandardError
    false
  end

  def show_usage_and_exit
    puts "Usage:
ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
*seed* should be an integer
*num_prospectors* should be a non-negative integer
*num_turns* should be a non-negative integer"
    exit 1
  end
end
