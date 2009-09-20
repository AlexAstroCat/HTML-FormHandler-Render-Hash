#!perl -T

use Test::More tests => 16;
use Test::Differences;
use HTML::FormHandler;

{
   package Test::Form;
   use HTML::FormHandler::Moose;
   extends 'HTML::FormHandler';
   with 'HTML::FormHandler::Render::Hash';

   has '+name' => ( default => 'testform' );
   has_field 'number';
   has_field 'fruit' => ( type => 'Select', css_class => 'Booyah' );
   has_field 'vegetables' => ( type => 'Multiple' );
   has_field 'opt_in' => ( type => 'Select', widget => 'radio_group',
      options => [{ value => 0, label => 'No'}, { value => 1, label => 'Yes'} ] );
   has_field 'active' => ( type => 'Checkbox' );
   has_field 'comments' => ( type => 'TextArea' );
   has_field 'hidden' => ( type => 'Hidden' );
   has_field 'selected' => ( type => 'Boolean' );
   has_field 'start_date' => ( type => 'DateTime' );
   has_field 'start_date.month' => ( type => 'Integer', range_start => 1,
       range_end => 12 );
   has_field 'start_date.day' => ( type => 'Integer', range_start => 1,
       range_end => 31 );
   has_field 'start_date.year' => ( type => 'Integer', range_start => 2000,
       range_end => 2020 );

   has_field 'submit' => ( type => 'Submit', value => 'Update' );

   has '+dependency' => ( default => sub { [ ['start_date.month',
         'start_date.day', 'start_date.year'] ] } );
   sub options_fruit {
       return (
           1   => 'apples',
           2   => 'oranges',
           3   => 'kiwi',
       );
   }

   sub options_vegetables {
       return (
           1   => 'lettuce',
           2   => 'broccoli',
           3   => 'carrots',
           4   => 'peas',
       );
   }
}


my $form = Test::Form->new;
ok( $form, 'create form');

my $params = {
   test_field => 'something',
   number => 0,
   fruit => 2,
   vegetables => [2,4],
   active => 'now',
   comments => 'Four score and seven years ago...',
   hidden => '1234',
   selected => '1',
   'start_date.month' => '7',
   'start_date.day' => '14',
   'start_date.year' => '2006',
   two_errors => 'aaa',
   opt_in => 0,
};

$form->process( $params );

my $number_field = {
    name       => 'number',
    id         => 'number',
    label      => 'Number',
    label_type => 'label',
    value      => 0,
    widget     => 'text'
};
eq_or_diff($form->render_field( $form->field('number') ), $number_field, 'text field');

my $fruit_field = {
    class => 'Booyah',
    name => 'fruit',
    id => 'fruit',
    label => 'Fruit',
    label_type => 'label',
    multiple => '',
    options => {
      option => [
        {
          id => 'fruit.0',
          label => 'apples',
          value => 1
        },
        {
          id => 'fruit.1',
          label => 'oranges',
          selected => 1,
          value => 2
        },
        {
          id => 'fruit.2',
          label => 'kiwi',
          value => 3
        }
      ]
    },
    widget => 'select'
};
eq_or_diff($form->render_field( $form->field('fruit') ), $fruit_field, 'select field');

my $vegetables_field = {
    name => 'vegetables',
    id => 'vegetables',
    label => 'Vegetables',
    label_type => 'label',
    multiple => 1,
    options => {
      option => [
        {
          id => 'vegetables.0',
          label => 'lettuce',
          value => 1
        },
        {
          id => 'vegetables.1',
          label => 'broccoli',
          selected => 1,
          value => 2
        },
        {
          id => 'vegetables.2',
          label => 'carrots',
          value => 3
        },
        {
          id => 'vegetables.3',
          label => 'peas',
          selected => 1,
          value => 4
        },
      ]
    },
    size => '5',
    widget => 'select'
};
eq_or_diff($form->render_field( $form->field('vegetables') ), $vegetables_field, 'multiple select field');

my $opt_in_field = {
    name => 'opt_in',
    id => 'opt_in',
    label => 'Opt_in',
    label_type => 'label',
    options => {
      option => []
    },
    value => 0,
    widget => 'radio_group'
};
eq_or_diff($form->render_field( $form->field('opt_in') ), $opt_in_field, 'radio group field');

my $active_field = {
    checkbox_value => '1',
    name => 'active',
    id => 'active',
    label => 'Active',
    label_type => 'label',
    value => 'now',
    widget => 'checkbox'
};
eq_or_diff($form->render_field( $form->field('active') ), $active_field, 'checkbox field');

my $comments_field = {
    cols => 10,
    name => 'comments',
    id => 'comments',
    label => 'Comments',
    label_type => 'label',
    rows => 5,
    value => 'Four score and seven years ago...',
    widget => 'textarea'
};
eq_or_diff($form->render_field( $form->field('comments') ), $comments_field, 'textarea field');

my $hidden_field = {
    name => 'hidden',
    id => 'hidden',
    label => 'Hidden',
    value => '1234',
    widget => 'hidden'
};
eq_or_diff($form->render_field( $form->field('hidden') ), $hidden_field, 'hidden field');

my $selected_field = {
    checkbox_value => '1',
    checked => 1,
    name => 'selected',
    id => 'selected',
    label => 'Selected',
    label_type => 'label',
    value => '1',
    widget => 'checkbox'
};
eq_or_diff($form->render_field( $form->field('selected') ), $selected_field, 'boolean field');

my $month_field = {
    name => 'start_date.month',
    id => 'start_date.month',
    label => 'Month',
    label_type => 'label',
    size => '8',
    value => '7',
    widget => 'text'
};
eq_or_diff($form->render_field( $form->field('start_date.month') ), $month_field, 'datetime month field');

my $day_field = {
    name => 'start_date.day',
    id => 'start_date.day',
    label => 'Day',
    label_type => 'label',
    size => '8',
    value => '14',
    widget => 'text'
};
eq_or_diff($form->render_field( $form->field('start_date.day') ), $day_field, 'datetime day field');

my $year_field = {
    name => 'start_date.year',
    id => 'start_date.year',
    label => 'Year',
    label_type => 'label',
    size => '8',
    value => '2006',
    widget => 'text'
};
eq_or_diff($form->render_field( $form->field('start_date.year') ), $year_field, 'datetime year field');

my $start_date_field = {
    field => [
      $month_field,
      $day_field,
      $year_field,
    ],
    name => 'start_date',
    id => 'start_date',
    label => 'Start_date',
    label_type => 'legend',
    widget => 'compound'
};
eq_or_diff($form->render_field( $form->field('start_date') ), $start_date_field, 'datetime field');

my $submit_field = {
    name   => 'submit',
    id     => 'submit',
    label  => 'Submit',
    value  => 'Update',
    widget => 'submit'
};
eq_or_diff($form->render_field( $form->field('submit') ), $submit_field, 'submit field');

my $output = $form->render;
ok( $output, 'get rendered output from form');
eq_or_diff(
    $output,
    {
        method => 'post',
        name   => 'testform',
        field  => [
            $number_field,
            $fruit_field,
            $vegetables_field,
            $opt_in_field,
            $active_field,
            $comments_field,
            $hidden_field,
            $selected_field,
            $start_date_field,
            $submit_field,
        ],
    },
    'get rendered output from form'
);
