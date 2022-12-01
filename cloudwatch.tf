# resource "aws_cloudwatch_log_group" "log-group" {
#   name = var.logname
# }

#create custom metric for log group

resource "aws_cloudwatch_log_metric_filter" "metric-filter" {
  name           = var.metric_name
  log_group_name = var.logname
  pattern        =  var.pattern
  metric_transformation {
    name      = var.metric_name
    namespace = var.namespace
    value     = "1"
  }
}

  #create cloudwatch alarm for custom metric          


resource "aws_cloudwatch_metric_alarm" "cloudwatch-error-alarm" {
  depends_on = [
    aws_cloudwatch_log_metric_filter.metric-filter
  ]
  alarm_name = "cloudwatch-error-alarm"
  metric_name         = aws_cloudwatch_log_metric_filter.metric-filter.name
  threshold           = "0"
  statistic           = "Sum"
  comparison_operator = "GreaterThanThreshold"
  datapoints_to_alarm = "1"
  evaluation_periods  = "1"
  period              = "10"
  namespace           = var.namespace
  treat_missing_data = "notBreaching"
  alarm_actions       = [aws_sns_topic.topic.arn]
}

 # Create SNS and email subscription

resource "aws_sns_topic" "topic" {
  name = var.Notification-mail
}


resource "aws_sns_topic_subscription" "target" { 
  count     = length(local.emails)
  topic_arn = aws_sns_topic.topic.arn 
  protocol  = "email" 
  endpoint  = local.emails[count.index] 
}