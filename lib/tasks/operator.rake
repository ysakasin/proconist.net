namespace :operator do
  # rake operator:add [ADMIN=true]
  desc '管理者のログイン情報を登録'
  task add: :environment do
    print 'id:'
    id = STDIN.gets.chomp
    raise 'Duplicate id' if Operator.where(identifier: id).exists?
    operator = Operator.new
    operator.identifier = id
    operator.name = id
    operator.position = 1 if ENV['ADMIN'] == 'true'

    print 'password:'
    pass = STDIN.noecho(&:gets).chomp
    print "\nconfirm password:"
    conf = STDIN.noecho(&:gets).chomp

    if pass.present? && pass == conf
      operator.password = pass
      operator.save
      print "\nSaved.\n"
    else
      print "\nError.\n"
    end
  end
end
