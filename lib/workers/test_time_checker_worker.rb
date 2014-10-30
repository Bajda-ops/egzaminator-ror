class TestTimeCheckerWorker < BackgrounDRb::MetaWorker

  include TestCheckerMethod
  set_worker_name :test_time_checker_worker

  def create(args = nil)
    # this method is called, when worker is loaded for the first time
    add_periodic_timer(1) { check_tests }
  end

  def check_tests
    ActiveTest.save_finished_tests
  end

end

