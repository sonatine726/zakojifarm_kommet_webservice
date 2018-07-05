$(document).ready ->
  $('div.buttons').on 'click', 'button#update-entries-button', ->
    approved = []
    not_approved = []
    canceled = []
    not_canceled = []

    $('table.p-program-entries input.approved').each ->
      if $(this).prop('checked')
        approved.push $(this).data('entry-id')
      else
        not_approved.push $(this).data('entry-id')
    $('#form_approved').val(approved.join(':'))
    $('#form_not_approved').val(not_approved.join(':'))

    $('table.p-program-entries input.canceled').each ->
      if $(this).prop('checked')
        canceled.push $(this).data('entry-id')
      else
        not_canceled.push $(this).data('entry-id')

    $('#form_canceled').val(canceled.join(':'))
    $('#form_not_canceled').val(not_canceled.join(':'))

    $('div.buttons form').submit()
