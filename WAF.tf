
# WAF is configured to only allow inbound traffic from 110.174.126.162 DWS adelaide IP.
resource "aws_waf_ipset" "ipset" {
  name = "tfIPSet"

  ip_set_descriptors {
    type  = "IPV4"
    value = "110.174.126.162/32"
  }
}

resource "aws_waf_rule" "wafrule" {
  depends_on  = [aws_waf_ipset.ipset]
  name        = "tfWAFRule"
  metric_name = "tfWAFRule"

  predicates {
    data_id = aws_waf_ipset.ipset.id
    negated = false
    type    = "IPMatch"
  }
}